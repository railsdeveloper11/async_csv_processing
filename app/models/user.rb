class User < ApplicationRecord
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

    validates_format_of :first, :last, :with => /^[a-z]+$/im, :multiline => true, :allow_blank => true
    validate :validate_first_if_last

    def self.import(file, identifier_id)
        identifier = Identifier.find(identifier_id) rescue nil
        CSV.foreach(file.path, headers: true).with_index do |row, index|
            user = User.create row.to_hash
            if user.save
                identifier.success_responses << identifier.success_responses.create({row_number: index+1, message: "Row saved succesfully"})    
            else
                identifier.error_responses << identifier.error_responses.create({row_number: index+1, message: "Row can not be saved as #{user.errors.full_messages.to_sentence}"})    
            end    
        end     
    end

    def validate_first_if_last
       if last.present? && !first.present?
        errors.add(:first, 'first is mandatory if you are adding second')
       end
    end    
end
