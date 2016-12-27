require 'test_helper'

class MainTest < ActionDispatch::IntegrationTest

  test 'Ограничения доступа гостям' do
    @routes = ['/chat_rooms', '/edit_profile']
    @routes.each do |x|
      get x
      assert_response :redirect
      follow_redirect!
      assert_equal 200, status
      assert_equal new_user_session_path, path
    end
  end

  test 'Регистрация и создание беседы' do
    user = User.create(
        :email => 'user@mail.com',
        :password => 'MyTestingPassword',
        :password_confirmation => 'MyTestingPassword',
    )
    chat_name = 'Беседа'
    # Вход
    post '/users/sign_in',
         params: {'user[email]' => user.email, 'user[password]' => user.password}
    assert_response :redirect
    follow_redirect!
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal '/edit_profile', path
    # Заполнение профиля
    patch '/edit_profile',
          params:{'user[first_name]' => 'Иван','user[last_name]' => 'Иванов','user[country]' => 'Россия','user[city]' => 'Москва'}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal '/chat_rooms',path
    post '/chat_rooms',
        params: {'chat_room[tittle]' => chat_name}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal '/chat_rooms/1', path
  end


end
