class Address < ApplicationRecord
    belongs_to :member
    
    def full_adresses

     self.post_code + " " + self.address + " " + self.name
    end
    # https://blog.hippohack.me/web/52
end
