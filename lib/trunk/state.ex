defmodule Trunk.State do
  defstruct ~w(module file opts filename rootname extname versions async version_timeout scope storage storage_opts)a
  @type t :: %__MODULE__{module: atom, filename: String.t, rootname: String.t, extname: String.t, versions: list, async: boolean, version_timeout: integer, scope: map | struct, storage: atom, storage_opts: list}

  def init(%{} = info, scope, opts) do
    filename = info[:filename]
    module = info[:module]
    file = info[:file]

    %__MODULE__{
      module: module,
      file: file,
      # opts: opts,
      filename: filename,
      extname: Path.extname(filename),
      rootname: Path.rootname(filename),
      versions: opts |> Keyword.fetch!(:versions) |> Enum.map(&({&1, %{}})) |> Map.new,
      version_timeout: Keyword.fetch!(opts, :version_timeout),
      async: Keyword.fetch!(opts, :async),
      storage: Keyword.fetch!(opts, :storage),
      storage_opts: Keyword.fetch!(opts, :storage_opts),
      scope: scope,
    }
  end
end
