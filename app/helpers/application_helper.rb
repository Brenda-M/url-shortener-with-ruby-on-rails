module ApplicationHelper
  def flash_class
    case flash.keys.first.to_sym
    when :notice
      'bg-green-200 text-green-800 border-green-400'
    when :alert
      'bg-error text-red-800 border-red-400'
    else
      'bg-gray-200 text-gray-800 border-gray-400'
    end
  end
end
