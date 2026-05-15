module SecretsManager
  class << self
    def get
      Rails.cache.fetch("secrets_manager", expires_in: 1.hour) do
        client = Aws::SecretsManager::Client.new(region: "ap-northeast-1")
        begin
          get_secret_value_response = client.get_secret_value(secret_id: "secret_demo")
        rescue StandardError => e
          raise e
        end
        get_secret_value_response.secret_string
      end
    end
  end
end
