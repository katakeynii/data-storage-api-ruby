# Coding Exercise: Data Storage API

Implement a small HTTP service to store objects organized by repository.
Clients of this service should be able to GET, PUT, and DELETE objects.

## Expectations

We ask that you spend no more than 2 hours on this exercise. We value your time and don't want to set unreasonable expectations on how long you should work on this exercise.

We ask you complete this exercise so you have an opportunity to build a service in your own time rather than an in-person interview, coding on a whiteboard.

## General Requirements

* The service should de-duplicate data objects by repository.
* The service should listen on port `8282`.
* The included tests should pass and not be modified. Adding additional tests is encouraged.
* The service must implement the API as described below.
* The data can be persisted in memory, on disk, or wherever you like.
* Do not include any extra dependencies.

## Suggestions

* Your code will be read by humans, so organize it sensibly.
* Use this repository to store your work. Committing just the final solution is *ok* but we'd love to see your incremental progress. We suggest taking a look at [GitHub flow](https://guides.github.com/introduction/flow/) to structure your commits.
* [Submit a pull request](https://help.github.com/articles/creating-a-pull-request/) once you are happy with your work.
* Treat this pull request as if you’re at work submitting it to your colleagues, or to an open source project. The body of the pull request can be used to describe your reasoning and any assumptions or tradeoffs in your implementation.

## API

### Upload an Object

```
PUT /data/{repository}
```

#### Response

```
Status: 201 Created
{
  "oid": "2845f5a412dbdfacf95193f296dd0f5b2a16920da5a7ffa4c5832f223b03de96",
  "size": 1234
}
```

### Download an Object

```
GET /data/{repository}/{objectID}
```

#### Response

```
Status: 200 OK
{object data}
```

Objects that are not on the server will return a `404 Not Found`.

### Delete an Object

```
DELETE /data/{repository}/{objectID}
```

#### Response

```
Status: 200 OK
```

## Getting started and Testing
In server-rack.rb you'll find a naive first draft of the answer to the exercise written for you. Please improve this draft so that it passes the test written in test.rb. You might need to install rack:

```
gem install rack rack-test
```

You can test that this works by running:

```
ruby test.rb
```

Once you have a good version of `server-rack.rb` please submit that file in a pull request.

Behind the scenes we add the following `.travis.yml` file to your code:

```
language: ruby
rvm:
 - 2.4.4
before_script:
 - cd ./ruby
 - gem install rack rack-test
script:
 - ruby test.rb
```

So please don't move tests or add in dependencies.
