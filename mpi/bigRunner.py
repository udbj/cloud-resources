from mpi4py import MPI
from collections import Counter
from itertools import islice
import json
import time

def addCounter(counter1, counter2, datatype):
    return counter1 + counter2


if __name__=="__main__":

    comm = MPI.COMM_WORLD

    print('Process ', comm.rank, ' started!')

    hashCounts = Counter()
    langCounts = Counter()

    total_tweets = 4057525

    tweets_per_proc = int(total_tweets / comm.size)
    start = comm.rank * tweets_per_proc
    end = (comm.rank+1) * tweets_per_proc
    step = 10000




    if comm.rank == 0:
      t1 = time.time()

    if comm.rank == comm.size -1:
      end = total_tweets

    current = start
    
    while current < end:
      with open('bigTwitter.json') as f:
        stop = (current + step) if (current + step) < end else end
        lines = islice(f, current, stop)
        
        current = current + step

        for line in lines:
          try:
            jObj = json.loads(line.rstrip().rstrip(','))
            lang = jObj['doc']['metadata']['iso_language_code']
            hashList = jObj['doc']['entities']['hashtags']
          
            langCounts.update([lang])
          
            for hashDat in hashList:
              hashCounts.update([hashDat['text'].lower()])
          except ValueError:
            print('JSON parsing error.')



    counterSumOp = MPI.Op.Create(addCounter, commute=True)

    tweetCounter = comm.reduce(hashCounts, op = counterSumOp)
    langCounter = comm.reduce(langCounts, op = counterSumOp)

    if comm.rank == 0:
      t2 = time.time()
      print(comm.rank, tweetCounter.most_common(10))
      print(comm.rank, langCounter.most_common(10))

      print('Time taken: ', t2-t1)