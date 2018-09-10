defmodule ClusterEcsTest do
  use ExUnit.Case
  alias Cluster.Strategy.State

  # Need to figure out how to stub this out
  test "gets those ips" do
    state = %State {
      topology: ClusterEcs.Strategy,
      config: [
        cluster: "arn:aws:ecs:us-east-2:915236037149:cluster/staging-ecs-cluster",
        service_name: "-TrainingDat-",
        region: "us-east-2",
        app_prefix: "mega-maid",
      ]
    }

    assert {:ok, ips} = ClusterEcs.Strategy.get_nodes(state)
    assert MapSet.difference(MapSet.new([:"mega-maid@10.1.123.163", :"mega-maid@10.1.164.239"]), ips) == MapSet.new([])
  end
end
