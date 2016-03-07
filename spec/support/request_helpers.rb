module Request
  module JsonHelpers
  
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  module HeadersHelpers
    def api_helpers(version = 1)
      request.headers['Accept'] = "application/vnd.marketplace.v#{version}"
    end

    def api_response_format(format = Mime::JSON)
      request.headers['Accept'] = "#{request.headers['Accept']}, #{format}"
      request.headers['Content-Type'] = format.to_s
    end

    def include_default_accept_headers
      api_helpers
      api_response_format
    end

    def api_authorization_header(token)
      request.headers['Authorization'] =  token
    end

  end
end
