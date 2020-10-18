module APIHelper
  module_function

  # matcher is only available for curly brackets format ({}, {{}}, and so on)
  def resolve_variable(obj, target, matcher = /\{([a-zA-Z0-9_]+)\}/)
    resolved = target.gsub!(matcher) do |var|
      var.gsub!(/[\{\}]/, '')

      value = obj.instance_variable_get("@#{var}")
      puts "Variable @#{var} is nil or false!" unless value

      value
    end || target

    resolved.gsub(/ENV:([a-zA-Z0-9_]+)/) { |env_var| ENV[env_var[4..-1]] } || resolved
  end
end