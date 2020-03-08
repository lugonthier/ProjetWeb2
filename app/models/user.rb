class User < ApplicationRecord

    
    has_secure_password
    has_secure_token :confirmation_token
    has_many :sports, dependent: :destroy
    has_many :posts, dependent: :destroy
    has_image :photo, resize: '600x300', formats: {
        thumb: '150x150'
      }

    has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
    has_many :followees, through: :followed_users
    
    has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
    has_many :followers, through: :following_users

   
   

    validates :username, format: {with: /\A[a-zA-Z0-9_]{2,20}\z/, message: 'ne doit contenir que des caractères alphanumériques ou _'},
        uniqueness: {case_sensitive: false}

    validates :email, format: {with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/},
    uniqueness: {case_sensitive: false}

    validates :firstname,
    format: {with: /\A[a-z]+$\z/, message: "ne peut contenir que des lettres en minuscules"}

    validates :lastname,
     format: {with: /\A^[a-z]+$\z/, message: "ne peut contenir que des lettres en minuscules"}


    def followedBy?(user)
        following_users.where(follower_id: user.id).count > 0 if user.respond_to? :id  
    end

    #return the username of follower or followee
    def followToUsername(id)
        User.find_by_id(id).username
   
    end

    def usernameToId(username)
        User.find_by_username(username).id
    end

  def followeePosts(ids)
    #retourne les 5 derniers posts de chacun de ses abonnements dans un array.
    users = User.where({id: ids})
    length = ids.length
    filter = []
    if length != 0
        for i in (0..(length-1))
          if users[i] != nil # Si jamais un utilisateur a été supprimé, il sera nil
            if users[i].posts.all.length > 4
                for j in ((length - 5)..(length-1))
                    filter << users[i].posts[j]
                end
            else
                for k in users[i].posts
                    filter << k
                end
            end
          end
        end
        #Tri bulle pour trier par date.

        if filter.length > 1
            x = filter.length-1
            while x >= 1
                
                for j in (0..(x-1))
                    
                    if filter[j+1].created_at < filter[j].created_at
                        switch = filter[j+1]
                        filter[j+1] = filter[j]
                        filter[j] = switch
                    end
                end
                x = x-1
            end
        end
    end
   filter
end



=begin
    # This in comment is a model used which only concerns the one who developed.
    # I used it first, then I generalized it in "image_concern.rb".

    validates :photo_file, file: {ext: [:jpg, :png]}

    attr_accessor :photo_file
    
    validates :photo_file, file: {ext: [:jpg, :png]}
    after_save :photo_upload
    before_save :photo_before_upload
    after_destroy_commit :photo_destroy


#pour ne pas se répéter
    def to_session

        {id: id}
    
    end

    def photo_path
        File.join(Rails.public_path, self.class.name.downcase.pluralize, id.to_s,'photo.jpg')
    end
  
  
    def photo_url
        '/' + [self.class.name.downcase.pluralize, id.to_s, 'photo.jpg'].join('/')
    end
  
  
    def photo_upload
        
        path = photo_path
  
        if photo_file.respond_to? :path
          dir = File.dirname(path)
          FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
          
          image = MiniMagick::Image.new(photo_file.path) do |b|
  
            b.resize '150x150'
            b.gravity 'Center'
            b.crop '150x150+0+0'
          end
  
          image.format 'jpg'
          image.write path
        end
  
    end
  
  
    def photo_before_upload
        if photo_file.respond_to? :path
            self.photo = true
        end
    end
  
      
    def photo_destroy
      dir = File.dirname(photo_path)
  
      FileUtils.rm_r(dir) if Dir.exist?(dir)
  
    end
=end
    
end
