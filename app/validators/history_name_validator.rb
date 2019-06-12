class HistoryNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.include?(' ') || value.include?("　")  #全角・半角スペースが含まれるか？
      record.errors[attribute] << (options[:message] || "にはスペースを含めないでください")
    end
  end
end