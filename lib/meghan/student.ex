defmodule Meghana.Student do
  defstruct [:student_id, completed_courses: []]

  def new(student_id) do
    %__MODULE__{student_id: student_id}
  end

  def complete_course(student, course_code) do
    %{student | completed_courses: [course_code | student.completed_courses]}
  end
end
