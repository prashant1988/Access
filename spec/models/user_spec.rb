require 'spec_helper'

describe User do

  before{@user=User.new(:email=>'xyz@msn.com',
                        :password=>'123456',
                        :password_confirmation=>'123456',
                        :remember_me=>'xyz@msn.com')}

  subject{@user}

          it{should respond_to(:email)}
          it{should respond_to(:password)}
          it{should respond_to(:password_confirmation)}
          it{should respond_to(:remember_me)}



end
