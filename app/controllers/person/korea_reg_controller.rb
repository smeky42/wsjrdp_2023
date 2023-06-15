# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

require 'net/http'
require 'uri'


class Person::KoreaRegController < ApplicationController
  before_action :authorize_action
  decorates :group, :person

  def index
    @group ||= Group.find(params[:group_id])
    @person ||= group.people.find(params[:id])

    save_put
  end

  private

  def entry
    @person ||= Person.find(params[:id])
  end

  def authorize_action
    authorize!(:edit, entry)
  end

  # dirty stuff to remote crontrol the korean registration system
  def read_token_from_response(response)
    utf8_body = response.body.encode('UTF-8', invalid: :replace, undef: :replace, replace: '?')

    token_line = utf8_body.lines.find { |l| l.include?('token') }.to_s
    Rails.logger.debug 'Token Line: ' + token_line
    token = token_line.gsub('<input type="hidden" name="token" value="', '')
    token = token.gsub(/.*token=/, '').gsub(/".*/, '')
    token = token.strip
    Rails.logger.debug 'Token: ' + token
    token
  end

  def initial_token_request
    url = URI.parse('https://register.2023wsjkorea.org/home/sub.php?menukey=1637&language=en')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    # http.set_debug_output($stderr)

    headers = {
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
      'Accept-Language' => 'de,en-US;q=0.7,en;q=0.3',
      'Connection' => 'keep-alive',
      'Upgrade-Insecure-Requests' => '1'
    }

    request = Net::HTTP::Get.new(url, headers)
    response = http.request(request)

    # Save cookies to variable
    cookie = response.get_fields('set-cookie')
    token = read_token_from_response(response)

    [cookie, token]
  end

  def login_request(cookie, token)
    korea_secret = YAML.load_file(Rails.root.join('' \
                                    '../hitobito_wsjrdp_2023/config/korea_secret.yml'))

    url = URI('https://register.2023wsjkorea.org/home/member.php')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    # http.set_debug_output($stderr)

    headers = {
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
      'Accept-Language' => 'de,en-US;q=0.7,en;q=0.3',
      'Content-Type' => 'application/x-www-form-urlencoded',
      'Origin' => 'https://register.2023wsjkorea.org',
      'Connection' => 'keep-alive',
      'Referer' => 'https://register.2023wsjkorea.org/home/sub.php?menukey=1637',
      'Upgrade-Insecure-Requests' => '1',
      'Sec-Fetch-Site' => 'same-origin',
      'Cookie' => cookie
    }

    data = {
      mod: 'process',
      act: 'mgsLogin',
      rtnUrl: '',
      token: token,
      info1: korea_secret.first,
      info2: korea_secret.second
    }

    request = Net::HTTP::Post.new(url, headers)
    request.set_form_data(data)

    response = http.request(request)
    read_token_from_response(response)
  end

  def reset_passwort_token_request(cookie)
    url = URI("https://register.2023wsjkorea.org/home/sub.php?menukey=1638&mod=list_manage&search=Y&cate=&scode=00000004&code2=&code3=&listCnt=20&kwd=#{@person.korea_id}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    # http.set_debug_output($stderr)

    headers = {
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
      'Accept-Language' => 'de,en-US;q=0.7,en;q=0.3',
      'Connection' => 'keep-alive',
      'Referer' => 'https://register.2023wsjkorea.org/home/sub.php?menukey=1638',
      'Cookie' => cookie,
      'Upgrade-Insecure-Requests' => '1'
    }

    request = Net::HTTP::Get.new(url, headers)

    response = http.request(request)
    read_token_from_response(response)
  end

  def reset_password_request(cookie, token)
    url = URI("https://register.2023wsjkorea.org/home/sub.php?menukey=1638&search=Y&kwd=#{@person.korea_id}&scode=00000004&listCnt=20")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    # http.set_debug_output($stderr)

    headers = {
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
      'Accept-Language' => 'de,en-US;q=0.7,en;q=0.3',
      'Content-Type' => 'application/x-www-form-urlencoded',
      'Origin' => 'https://register.2023wsjkorea.org',
      'Connection' => 'keep-alive',
      'Referer' => "https://register.2023wsjkorea.org/home/sub.php?menukey=1638&mod=list_manage&search=Y&kwd=#{@person.korea_id}&scode=00000004&listCnt=20",
      'Cookie' => cookie,
      'Upgrade-Insecure-Requests' => '1'
    }

    data = {
      mod: 'process',
      act: 'initPass_wsj',
      app_idcd: "#{@person.korea_id}|",
      app_status: 'reset',
      token: token
    }

    request = Net::HTTP::Post.new(url, headers)
    request.set_form_data(data)

    response = http.request(request)
    read_token_from_response(response)
  end

  def initial_user_request
    url = URI('https://register.2023wsjkorea.org/home/sub.php?menukey=1625&language=en')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    # http.set_debug_output($stderr)

    headers = {
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
      'Accept-Language' => 'de,en-US;q=0.7,en;q=0.3',
      'Connection' => 'keep-alive',
      'Upgrade-Insecure-Requests' => '1'
    }

    request = Net::HTTP::Get.new(url, headers)
    response = http.request(request)

    # Save cookies to variable
    cookie = response.get_fields('set-cookie')
    token = read_token_from_response(response)

    [cookie, token]
  end

  def user_login_request(cookie, token)
    url = URI('https://register.2023wsjkorea.org/home/member.php')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    # http.set_debug_output($stderr)

    headers = {
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
      'Accept-Language' => 'de,en-US;q=0.7,en;q=0.3',
      'Content-Type' => 'application/x-www-form-urlencoded',
      'Origin' => 'https://register.2023wsjkorea.org',
      'Connection' => 'keep-alive',
      'Referer' => 'https://register.2023wsjkorea.org/home/sub.php?menukey=1625&language=en',
      'Cookie' => cookie,
      'Upgrade-Insecure-Requests' => '1',
      'Sec-Fetch-Site' => 'same-origin'
    }

    data = {
      mod: 'process',
      act: 'memberLogin',
      rtnUrl: 'register.2023wsjkorea.org/home/main.php',
      token: token,
      info1: @person.korea_id,
      info2: @person.birthday.strftime('%Y%m%d') + 'DE'
    }

    request = Net::HTTP::Post.new(url, headers)
    request.set_form_data(data)

    response = http.request(request)
    read_token_from_response(response)
  end

  def user_password_token_request(cookie)
    url = URI('https://register.2023wsjkorea.org/home/sub.php?menukey=1639')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    # http.set_debug_output($stderr)

    headers = {
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
      'Accept-Language' => 'de,en-US;q=0.7,en;q=0.3',
      'Connection' => 'keep-alive',
      'Referer' => 'https://register.2023wsjkorea.org/home/sub.php?menukey=1631',
      'Cookie' => cookie,
      'Upgrade-Insecure-Requests' => '1',
      'Sec-Fetch-Site' => 'same-origin'
    }

    request = Net::HTTP::Get.new(url, headers)

    response = http.request(request)
    read_token_from_response(response)
  end

  def set_user_password_request(cookie, token)
    new_password = 'D3#' + SecureRandom.base64(10)

    url = URI('https://register.2023wsjkorea.org/home/member.php')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    # http.set_debug_output($stderr)

    headers = {
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
      'Accept-Language' => 'de,en-US;q=0.7,en;q=0.3',
      'Content-Type' => 'application/x-www-form-urlencoded',
      'Origin' => 'https://register.2023wsjkorea.org',
      'Connection' => 'keep-alive',
      'Referer' => 'https://register.2023wsjkorea.org/home/sub.php?menukey=1639',
      'Cookie' => cookie,
      'Upgrade-Insecure-Requests' => '1',
      'Sec-Fetch-Site' => 'same-origin'
    }

    data = {
      mod: 'process',
      act: 'memberPassModify',
      token: token,
      info2: new_password,
      info3: new_password
    }

    request = Net::HTTP::Post.new(url, headers)
    request.set_form_data(data)

    response = http.request(request)

    if response.body.include? 'The password has been changed'
      Rails.logger.debug "===> Successfully changed Password for #{@person.korea_id}"
      new_password
    else
      Rails.logger.debug "Something went wrong: \n" + response.body
      'Password could not be reset'
    end
  end

  def save_put
    if request.put?
      Rails.logger.debug '====> Experimental Korea Password Reset'
      Rails.logger.debug '====> Initial Request'
      cookie_token = initial_token_request
      cookie = cookie_token[0][0].split(';')[0]
      token = cookie_token[1]

      Rails.logger.debug '====> Login Request'
      login_request(cookie, token)

      Rails.logger.debug '====> Reset Password Token Request'
      token = reset_passwort_token_request(cookie)
      # Rails.logger.info token
      Rails.logger.debug '====> Reset Password Request'
      reset_password_request(cookie, token)

      Rails.logger.debug '====> Initial User Request'
      cookie_token = initial_user_request
      cookie = cookie_token[0][0].split(';')[0]
      token = cookie_token[1]

      Rails.logger.debug '====> User Login Request'
      user_login_request(cookie, token)
      Rails.logger.debug '====> User Password Token Request'
      token = user_password_token_request(cookie)
      Rails.logger.debug '====> User Reset Password Request n#^RE4GiQcd*'
      new_password = set_user_password_request(cookie, token)

      if new_password != 'Error'
        flash[:notice] =
          "Das Passwort für den User #{@person.korea_id}  wurde auf #{new_password} zurückgesetzt."
      else
        flash[:alert] =
          'Leider ist beim Zurücksetzen etwas schief gelaufen, wahrscheinlich auf der koreanischen Seite. Versuche es daher bitte Morgen noch einmal.'
      end
      redirect_back(fallback_location: '/')
    end
  end

end
