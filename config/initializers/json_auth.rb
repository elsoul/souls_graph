module JsonAuth
  class JsonWebToken
    SECRET_KEY = ENV["SECRET_KEY_BASE"] || ""

    def self.encode payload, exp = 24.hours.from_now
      exp.to_i.zero? ? payload.delete(:exp) : payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    def self.decode token
      decoded = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new decoded
    end
  end
end
