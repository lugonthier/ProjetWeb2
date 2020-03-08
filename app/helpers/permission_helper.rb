module PermissionHelper

    def canEdit(record)
        if (record.respond_to?(:user_id) and is_user_signed_in and record.user_id === current_user.id) || current_user.admin
            true
        else
            false
        end
    end
end