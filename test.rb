require 'minitest/autorun'
require 'rack/test'
require_relative './server-rack'

class DataStorageServerTest < Minitest::Test
  include Rack::Test::Methods

  def app
    $database = {}
    DataStorageServer.new
  end

  def test_put

    put '/data/foo', 'some object'
    res = JSON.parse(last_response.body)
    assert_equal 201, last_response.status
    assert_equal 11, res["size"]
    assert res["oid"].is_a?(String)
    assert res["oid"].length > 0
  end

  def test_get
    put '/data/foo', 'some object'
    res1 = JSON.parse(last_response.body)

    put '/data/foo', 'other object'
    res2 = JSON.parse(last_response.body)

    refute_equal res1["oid"], res2["oid"]

    get "/data/foo/#{res1["oid"]}"
    assert_equal 'some object', last_response.body

    get "/data/foo/#{res2["oid"]}"
    assert_equal 'other object', last_response.body
  end

  def test_get_not_found
    get '/data/foo/noooope'
    assert_equal 404, last_response.status
  end

  def test_delete
    put '/data/foo', 'some object'
    res = JSON.parse(last_response.body)

    delete "/data/foo/#{res["oid"]}"
    assert_equal 200, last_response.status

    get "/data/foo/#{res["oid"]}"
    assert_equal 404, last_response.status
  end

  def test_delete_nonexistant_object
    delete "/data/foo/nooope"
    assert_equal 404, last_response.status
  end
end