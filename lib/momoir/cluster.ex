defmodule Momoir.Cluster do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, Node.list(), name: __MODULE__)
  end

  @impl true
  def init(state) do
		## Here we are setting up our stores
    Mnesiac.init_mnesia(Node.list())
    {:ok, state}
  end

  def children_spec() do
		# get our previously defined config
    case Application.get_env(:libcluster, :topologies) do
      nil ->
        nil

      topologies ->
        hosts = get_in(topologies, [:Momoir, :config, :hosts]) || []

        [
          {Cluster.Supervisor, [topologies, [name: Momoir.ClusterSupervisor]]},

					## Here we are adding our Mnesiac supervisor
					{Mnesiac.Supervisor, [hosts, [name: Momoir.MnesiacSupervisor]]}
        ]
    end
  end
end
