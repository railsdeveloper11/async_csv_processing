class Identifier < ApplicationRecord
   has_many :success_responses 
   has_many :error_responses 
end
