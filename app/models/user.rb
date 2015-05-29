require 'digest/md5'
require 'digest/sha1'

class User < ActiveRecord::Base
  self.table_name = "users"
  def authenticate_with_password(pwd)
    password = Digest::SHA1.hexdigest(Digest::MD5.hexdigest(pwd))
    password == self.password
  end
end

