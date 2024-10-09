defmodule Meghana.Module do
  defstruct [:course_code, prerequisite_codes: []]

  def new(course_code, prerequisite_codes \\ []) do
    %__MODULE__{course_code: course_code, prerequisite_codes: prerequisite_codes}
  end
end
