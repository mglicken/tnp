class Member < ActiveRecord::Base
	validates :name, :presence => true

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |members|
				csv << members.attributes.values_at(*column_names)
			end
		end
	end
	def self.import(file)
		allowed_attributes = [ "name", "organization","image","position","sequence","active"]
		CSV.foreach(file.path,headers: true) do |row|
			members = find_by_id(row["id"]) || new
			
			members.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
			
			members.save
		end
	end	

end
