# check if couchdb is running
curl http://127.0.0.1:5984/

# get list of databases
curl -X GET http://admin:password@127.0.0.1:5984/_all_dbs

# create new database
curl -X PUT http://admin:password@127.0.0.1:5984/baseball

# delete a database
curl -X DELETE http://admin:password@127.0.0.1:5984/plankton

# insert document
curl -H 'Content-Type: application/json' \
> -X POST http://admin:password@127.0.0.1:5984/baseball \
> -d '{"name":"John Yates"}'

# retrieve a particular document
curl -X GET http://admin:password@127.0.0.1:5984/baseball/4f4095e0e0640cbb0aa17f250a0009d3

# retrieve all docs
curl -X GET http://admin:password@127.0.0.1:5984/baseball/_all_docs

# create a design doc
$ curl -X PUT http://admin:password@localhost:5984/baseball/_design/ddoc -d '{"views":{"name":{"map":"function(doc) { emit(doc.name); }"}}}' -H'Content-Type:application/json'

# design doc from file
curl -X PUT -d @count_fun.js http://admin:password@localhost:5984/baseball/_design/counts 

# count_fun.js
{
  "views": {
    "count_res": {
      "map": "function(doc) { emit(doc._id, 1); }",
      "reduce": "function(keys, values) {return sum(values);}"
    }
  }
}

# get specific design doc
curl -X GET http://admin:password@127.0.0.1:5984/baseball/_design/ddoc

# list all design docs
curl -X GET http://admin:password@127.0.0.1:5984/baseball/_design_docs

# get result of map-reduce
curl -X GET http://admin:password@127.0.0.1:5984/baseball/_design/counts/_view/count_res
