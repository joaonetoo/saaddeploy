class AddAvatarToInstitutions < ActiveRecord::Migration
    def up
        add_attachment :institutions, :avatar
    end

    def down
        remove_attachment :institutions, :avatar
    end
end
