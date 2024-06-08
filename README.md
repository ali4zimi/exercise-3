## Exercise 3 for Cloud Computing

### Summer Semester 2024

#### For more enquiries, please contact me

Dear students,

Welcome to the third exercise for Cloud Computing. Now that you are experts on
Docker Compose, we are gonna explore building microservices (kind of, the idea
still holds).

During this assignment, you will explore the requirements of minimalizing your
containers for deploying microservices! You will also explore using a Load Balancer
to orchestrate traffic accross different endpoints.

As previous assignments, we will build on top of your existing code, which you
will partition into smaller to generate **five** different containers. So, what
is the task?

### The challenge

To succeed in this assignment, you must do the following:

1. Use Docker Compose to orchestrate your **five** containers and deploy **NGINX**
to control the traffic between your services based on the request method. The
containers are as follows:
    - A container to handle each operation for `/api/books`: GET, POST, PUT, and DELETE
    - A container to handle requests to `/*`, i.e., the rendering of the webpage.
    - A container for NGINX.
2. Use a Multi-stage Dockerfile to minimize the size of the image.
3. Publish to a public container registry (e.g., Docker Hub) your images.

### Requirements and Test Scenarios

#### Requirements

* You must create all images for `x86_64` (i.e., `amd64`).
* You must use a DB: you can run it as a container or install it directly in your VM.
* Create unique code-bases to handle each operation (GET, POST, PUT, DELETE, and
server-side rendering) by decoupling the current code structure.
* The URI for MongoDB must be given via an **environment variable**.
* The traffic must be redirected via **NGINX** by checking the request's method.
* Do not modify the headers inserted by NGINX.
* The automated tests from Exercise 1 must pass.

#### Tests

1. Using an insolated MongoDB instance, the submission server will download, configure, and
run all of your images. (10 pts).
2. Using the isolated instance, the submission server will perform tests to the 
different available endpoints (45 pts).
3. Using your VM, the submission server will perform tests with the given endpoint
and check that you are running **NGINX** with proper configuration (45 pts). Please
make sure the port in the given port matches the exposed one for NGINX.

### What do you need for this assignment?

The starting point is the code from your last exercise and your existing 
Docker Compose file. From there, you will have to expand such file to include:

- The configuration for NGINX. NGINX can be configured using an `nginx.conf` file
that you must pass to the respective container by mounting a volume into the
respective path. Please look at [this tutorial](https://www.digitalocean.com/community/tutorials/understanding-the-nginx-configuration-file-structure-and-configuration-contexts) by Digitial Ocean,
which explains the structure of the file. Since we want to redirect based on
request's methods, [this page](https://nginx.org/en/docs/http/ngx_http_core_module.html) *could* provide insightful information on how to configure your `$location`. [**Hint**](https://serverfault.com/questions/152745/nginx-proxy-by-request-method)
- Configure your other services to start in a timely manner so they are reachable
once NGINX is up.
- Use MongoDB to run before everything starts.

#### Extra options to explore

Since we are looking to optimize the size of a microservice's container, it might 
be useful to explore multi-stage builds to reduce the size of the final container.
You can read more [here](https://docs.docker.com/build/building/multi-stage/) on
how to create a multi-stage build. 

Basically, we want you to first build your executable: download necessary packages,
compile your code, and deploy on a thinner container. Given the multi-stage containers,
you can copy the compiled code (and necessary dependencies) from a previous stage
to the current one (a smaller one). Usually, people use an `alpine` version of linux
to deploy lightweight containers. That means, you build your code using the current heavy-
weight Golang container, you copy the final binary, and the required files (for 
rendering HTML) into the smaller stage, which generates a tiny image perfect 
for microservices.

If you want to improve your code even more and remove file dependencies, Golang
provides a neat feature called [`go-embed`](https://blog.jetbrains.com/go/2021/06/09/how-to-use-go-embed-in-go-1-16/)
to compile a given folder into the final binary to remove dependencies with the
host filesystem. Since I cannot check whether you are using such feature, I leave 
it to you to explore! 

### Happy Coding!
