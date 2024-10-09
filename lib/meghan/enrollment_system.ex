defmodule Meghana.EnrollmentSystem do
  alias Meghana.{Student, Module}

  def new do
    %{students: %{}, modules: %{}}
  end

  def add_student(system, student_id) do
    case Map.has_key?(system.students, student_id) do
      true ->
        {:error, "Student already exists", system}

      false ->
        new_student = Student.new(student_id)
        new_system = put_in(system, [:students, student_id], new_student)
        {:ok, new_student, new_system}
    end
  end

  def add_module(system, course_code, prerequisite_codes) do
    case Map.has_key?(system.modules, course_code) do
      true ->
        {:error, "Module already exists", system}

      false ->
        new_module = Module.new(course_code, prerequisite_codes)
        new_system = put_in(system, [:modules, course_code], new_module)
        {:ok, new_module, new_system}
    end
  end

  def enroll_student(system, student_id, course_code) do
    with {:ok, student} <- get_student(system, student_id),
         {:ok, module} <- get_module(system, course_code),
         :ok <- check_prerequisites(student, module) do
      updated_student = Student.complete_course(student, course_code)
      new_system = put_in(system, [:students, student_id], updated_student)
      {:ok, "Enrollment successful", new_system}
    else
      error -> {error, system}
    end
  end

  def get_student(system, student_id) do
    case Map.get(system.students, student_id) do
      nil -> {:error, "Student not found"}
      student -> {:ok, student}
    end
  end

  def get_module(system, course_code) do
    case Map.get(system.modules, course_code) do
      nil -> {:error, "Module not found"}
      module -> {:ok, module}
    end
  end

  defp check_prerequisites(student, module) do
    case Enum.all?(module.prerequisite_codes, &(&1 in student.completed_courses)) do
      true -> :ok
      false -> {:error, "Prerequisites not met"}
    end
  end
end
