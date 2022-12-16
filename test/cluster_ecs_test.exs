defmodule ClusterEcsTest do
  use ExUnit.Case
  alias Cluster.Strategy.State

  @cluster_arn "arn:aws:ecs:us-east-2:915236037149:cluster/staging-ecs-cluster"

  test "missing config" do
    state = %State {
      topology: ClusterEcs.Strategy,
      config: [
        cluster: @cluster_arn,
        region: "us-east-2",
        app_prefix: "merlin",
      ]
    }

    assert_raise KeyError, ~r(key :service_name not found), fn ->
      ClusterEcs.Strategy.get_nodes(state)
    end
  end

  test "misconfig" do
    state = %State {
      topology: ClusterEcs.Strategy,
      config: [
        cluster: @cluster_arn,
        service_name: [""],
        region: "us-east-2",
        app_prefix: "merlin",
      ]
    }

    assert {:error, "ECS strategy is selected, but service_name is not configured correctly!"} = ClusterEcs.Strategy.get_nodes(state)
  end

  # Need to figure out how to stub this out
  test "gets those ips" do
    state = %State {
      topology: ClusterEcs.Strategy,
      config: [
        cluster: @cluster_arn,
        service_name: "-Dat2-",
        region: "us-east-2",
        app_prefix: "mega_maid",
      ]
    }

    assert {:ok, ips} = ClusterEcs.Strategy.get_nodes(state)
    assert MapSet.size(ips) >= 1
    assert Enum.all?(ips, fn (ip) ->
      to_string(ip) =~ ~r/mega_maid@10\.1\.(\d{1,3})\.(\d{1,3})/
    end)
  end

  test "gets ips from multiple tasks" do
    state = %State {
      topology: ClusterEcs.Strategy,
      config: [
        cluster: @cluster_arn,
        service_name: ["-Merlin-", "-MerlinAdmin-"],
        region: "us-east-2",
        app_prefix: "merlin",
      ]
    }

    assert {:ok, ips} = ClusterEcs.Strategy.get_nodes(state)
    assert MapSet.size(ips) >= 1
    assert Enum.all?(ips, fn (ip) ->
      to_string(ip) =~ ~r/merlin@10\.1\.(\d{1,3})\.(\d{1,3})/
    end)
  end
end
