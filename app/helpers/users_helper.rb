module UsersHelper
    def avatar(user, size: 50)
        image_tag user.avatar.variant(resize_to_fill: [size, size], 
        # class: "user-avatar"
        ) if  user.avatar.attached?
    end
end