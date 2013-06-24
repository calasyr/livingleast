require 'Parser'

class Fetcher

    def initialize(account_id,message_id)
        raise unless account_id.is_a?(String) && message_id.is_a?(String)

        @account_id = account_id
        @message_id = message_id
    end

    def fetch
        key = "oicopl0j"
        secret = "UMuCWaigQvT2T7mf"

        contextio = ContextIO.new(key, secret)

        account = contextio.accounts[@account_id]
        message = account.messages[@message_id]

        message.body_parts.each do |part|

            p = Parser.new(part.content)

            if p.valid?
                return p
            end
        end

        return nil
    end 
end