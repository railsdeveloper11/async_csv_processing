class CsvWorker
    include Sidekiq::Worker
    require 'csv'
  
    def perform(file_path, identifier_id)
        identifier = Identifier.find(identifier_id) rescue nil
        CSV.foreach(file_path, headers: true).with_index do |row, index|            
            user = User.create row.to_hash
            if user.save
                identifier.success_responses << identifier.success_responses.create({row_number: index+1, message: "Row saved succesfully"})    
            else
                identifier.error_responses << identifier.error_responses.create({row_number: index+1, message: "Row can not be saved as #{user.errors.full_messages.to_sentence}"})    
            end    
        end     
    end
  end