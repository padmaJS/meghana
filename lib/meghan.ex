defmodule Meghan do
  alias Meghana.EnrollmentSystem

  def new_system, do: EnrollmentSystem.new()

  def add_student(system, student_id) do
    case EnrollmentSystem.add_student(system, student_id) do
      {:ok, _student, new_system} -> {:ok, new_system}
      {:error, message, _system} -> {:error, message}
    end
  end

  def add_module(system, course_code, prerequisite_codes) do
    case EnrollmentSystem.add_module(system, course_code, prerequisite_codes) do
      {:ok, _module, new_system} -> {:ok, new_system}
      {:error, message, _system} -> {:error, message}
    end
  end

  def enroll_student(system, student_id, course_code) do
    case EnrollmentSystem.enroll_student(system, student_id, course_code) do
      {:ok, message, new_system} -> {:ok, message, new_system}
      {{:error, message}, _system} -> {:error, message}
    end
  end

  def get_student(system, student_id), do: EnrollmentSystem.get_student(system, student_id)
  def get_module(system, course_code), do: EnrollmentSystem.get_module(system, course_code)
end
