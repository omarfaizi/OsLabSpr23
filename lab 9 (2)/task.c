#include <stdio.h>

#include <stdlib.h>

#include <pthread.h>

#include <semaphore.h>



#define MAX_THREADS 100

#define BUFFER_SIZE 100000



//global variables

int buffer[BUFFER_SIZE];

int counter = 0;

sem_t empty, full, mutex;


void *producer(void *args)

{

    int i;

    for (i = 0; i < BUFFER_SIZE; i++) {

        sem_wait(&empty);

        sem_wait(&mutex);

        buffer[counter++] = i;

        sem_post(&mutex);

        sem_post(&full);

    }

    pthread_exit(NULL);

}

void *consumer(void *args)

{

    int i, value;

    long int thread_id = (long int)args;

    for (i = 0; i < BUFFER_SIZE / MAX_THREADS; i++) {

        sem_wait(&full);

        sem_wait(&mutex);

        value = buffer[--counter];

        printf("Thread %ld: Consumed %d from buffer\n", thread_id, value);

        sem_post(&mutex);

        sem_post(&empty);

    }

    pthread_exit(NULL);
}



int main(int argc, char *argv[])

{

    pthread_t threads[MAX_THREADS];

    int num_threads, i;



    if (argc != 2) {

        printf("Usage: %s num_threads\n", argv[0]);

        exit(1);

    }



    num_threads = atoi(argv[1]);

    if (num_threads > MAX_THREADS) {
 printf("Maximum number of threads is %d\n", MAX_THREADS);

        exit(1);

    }



    //initialize semaphores

    sem_init(&empty, 0, BUFFER_SIZE);

    sem_init(&full, 0, 0);

    sem_init(&mutex, 0, 1);



    //create producer thread

    pthread_create(&threads[0], NULL, producer, NULL);



    //create consumer threads

    for (i = 1; i <= num_threads; i++) {
 pthread_create(&threads[i], NULL, consumer, (void *)(long int)i);

    }



    //join threads

    for (i = 0; i <= num_threads; i++) {

        pthread_join(threads[i], NULL);

    }
    }
