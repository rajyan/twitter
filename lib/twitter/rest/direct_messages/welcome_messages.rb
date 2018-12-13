require 'twitter/arguments'
require 'twitter/rest/upload_utils'
require 'twitter/rest/utils'
require 'twitter/utils'

module Twitter
  module REST
    module DirectMessages
      module WelcomeMessages
        include Twitter::REST::UploadUtils
        include Twitter::REST::Utils
        include Twitter::Utils

        # Welcome Message

        def create_welcome_message(text, name = nil, options = {})
          json_options = {
            welcome_message: {
              message_data: {
                text: text
              }
            }
          }
          json_options[:welcome_message][:name] = name if name
          event = perform_request_with_object(:json_post, '/1.1/direct_messages/welcome_messages/new.json', json_options.merge!(options), Twitter::WelcomeMessageWrapper)
          event.welcome_message
        end

        def destroy_welcome_message(*ids)
          perform_requests(:delete, '/1.1/direct_messages/welcome_messages/destroy.json', ids)
        end

        def update_welcome_message(welcome_message_id, text, options = {})
          params = {
            id: welcome_message_id
          }
          json_options = {
            message_data: {
              text: text
            }
          }
          event = perform_request_with_object(:json_put, '/1.1/direct_messages/welcome_messages/update.json', json_options.merge!(options), Twitter::WelcomeMessageWrapper, params)
          event.welcome_message
        end

        def welcome_message(id, options = {})
          options = options.dup
          options[:id] = id
          event = perform_get_with_object('/1.1/direct_messages/welcome_messages/show.json', options, Twitter::WelcomeMessageWrapper)
          event.welcome_message
        end

        def welcome_message_list(options = {})
          limit = options.fetch(:count, 20)
          events = perform_get_with_cursor('/1.1/direct_messages/welcome_messages/list.json', options.merge!(no_default_cursor: true, count: 50, limit: limit), :welcome_messages, Twitter::WelcomeMessageWrapper)
          events.collect(&:welcome_message)
        end

        # Welcome Message Rule

        def create_welcome_message_rule(welcome_message_id, options = {})
          json_options = {
              welcome_message_rule: {
                welcome_message_id: welcome_message_id
            }
          }
          event = perform_request_with_object(:json_post, '/1.1/direct_messages/welcome_messages/rules/new.json', json_options.merge!(options), Twitter::WelcomeMessageRuleWrapper)
          event.welcome_message_rule
        end

        def destroy_welcome_message_rule(*ids)
          perform_requests(:delete, '/1.1/direct_messages/welcome_messages/rules/destroy.json', ids)
        end

        def welcome_message_rule(id, options = {})
          options = options.dup
          options[:id] = id
          event = perform_get_with_object('/1.1/direct_messages/welcome_messages/rules/show.json', options, Twitter::WelcomeMessageRuleWrapper)
          event.welcome_message_rule
        end

        def welcome_message_rule_list(options = {})
          limit = options.fetch(:count, 20)
          events = perform_get_with_cursor('/1.1/direct_messages/welcome_messages/rules/list.json', options.merge!(no_default_cursor: true, count: 50, limit: limit), :welcome_message_rules, Twitter::WelcomeMessageRuleWrapper)
          events.collect(&:welcome_message_rule)
        end
      end
    end
  end
end
