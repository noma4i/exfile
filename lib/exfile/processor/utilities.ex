defmodule Exfile.Processor.Utilities do
  alias Exfile.LocalFile

  @doc """
  Takes a file and turns it in to a tempfile unless it already is a tempfile.
  Pass `true` as `create_new_tempfile` to force creation of a new tempfile.
  Returns a string containing the path to the tempfile.
  """
  @spec coerce_file_to_tempfile(%Exfile.LocalFile{}) :: %Exfile.LocalFile{}
  @spec coerce_file_to_tempfile(%Exfile.LocalFile{}, boolean) :: %Exfile.LocalFile{}
  def coerce_file_to_tempfile(file, create_new_tempfile \\ false)
  def coerce_file_to_tempfile(%LocalFile{path: path}, false) when not is_nil(path), do: path
  def coerce_file_to_tempfile(file, _) do
    new_file = LocalFile.copy_to_tempfile(file)
    new_file.path
  end

  @doc """
  Opens a LocalFile. Provided for compatibility reasons.
  """
  @spec coerce_file_to_io(%Exfile.LocalFile{}) :: :file.io_device
  def coerce_file_to_io(file) do
    {:ok, io} = LocalFile.open(file)
    io
  end
end
