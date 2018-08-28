libcluster_ecs
==============

This is an EC2 clustering strategy for
[libcluster](https://hexdocs.pm/libcluster/). It supports identifying nodes
running in Amazon ECS using the awsvpc networking mode. This mode gives each
instance its own IP address.

This strategy uses [ex_aws](https://github.com/ex-aws/ex_aws) to
query the describe services and describe task APIs. Access to this API should
be granted to the. See the ExAws docs for additional configuration options.

* EC2 Container Service ListTasks
* EC2 Container Service DiscribeTasks


```
config :libcluster,
  topologies: [
    example: [
      strategy: ClusterEcs.Strategy,
      config: [
        cluster: "my-cluster-name",
        service_name: "arn:aws:ecs:us-east-2:1234567:service/my-service",
        region: "us-east-1",
        app_prefix: "my-app",
      ],
    ]
  ]
```

## Installation

The package can be installed
by adding `libcluster_ecs` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:libcluster_ecs, "~> 0.4"}]
end
```
