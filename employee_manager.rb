class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  attr_reader :employees

  def initialize(name, title, salary, boss = nil)
    super
    @employees = []
  end

  def bonus(multiplier)
    self.salary_beneath * multiplier
  end

  def salary_beneath
    salary = 0
    self.employees.each do |employee|
      if employee.is_a?(Manager)
        salary += employee.salary_beneath
      end
      salary += employee.salary
    end
    salary
  end
end
