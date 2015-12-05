def errors_handler(record)
  record.errors.map do |key, value|
    flash.now["error_#{ key }".to_sym] = "#{ key } #{ value }"
  end
end