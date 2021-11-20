# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

class Person::AccountingController < ApplicationController
  include FinanceHelper
  include ActionView::Helpers::NumberHelper
  before_action :authorize_action
  decorates :group, :person

  def index
    @group ||= Group.find(params[:group_id])
    @person ||= group.people.find(params[:id])
    @accounting = accounting
    @accounting_entries = accounting_entries
    @accounting_payment_value = accounting_payment_value
    @accounting_payment_array = accounting_payment_array
    @accounting_balance = accounting_balance
    save_put
  end

  def accounting_value(value)
    text_value = value.to_f / 100
    number_to_currency(text_value, :separator => ",", :delimiter => ".", format: "%n %u")
  end
  helper_method :accounting_value

  private

  def entry
    @person ||= Person.find(params[:id])
  end

  def accounting
    current_user.role?('Group::Root::Admin') ||
    current_user.role?('Group::Root::Leader')
  end

  def authorize_action
    authorize!(:edit, entry)
  end

  # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/MethodLength,Metrics/AbcSize
  def save_put
    if @accounting && request.put? && !params[:accounting_comment].nil? && !params[:accounting_ammount].nil?
      AccountingEntries.create(id: AccountingEntries.count + 1,
                           subject_id: @person.id,
                           author_id: current_user.id,
                           ammount: params[:accounting_ammount],
                           comment: params[:accounting_comment],
                           created_at: DateTime.now)
      flash[:notice] =
      "Buchung #{params[:accounting_comment]} in Höhe von #{get_number_to_currency(params[:accounting_ammount].to_i/100)} erfolgreich angelegt!"
      redirect_back(fallback_location: "/")
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/MethodLength,Metrics/AbcSize

  def accounting_entries
    AccountingEntries.where(subject_id: @person.id)
  end

  def accounting_payment_value
    int_value = "-" + get_text_to_currency(get_payment_value)
  end

  def accounting_payment_array
    array = Array.new
    payment_array = payment_array_by(@person.role_wish).dup
    payment_array[0].each_index {
      |x| if payment_array[1][x] != " -   € " && payment_array[0][x] != "Gesamtbeitrag" && payment_array[1][x] != @person.role_wish
        array.push({
            month: payment_array[0][x],
            ammount: get_text_to_currency(payment_array[1][x])
        }
        )
      end
    }
    array
  end

  def accounting_balance
    balance = 0
    balance = 0 - get_payment_value[1...-3].to_i
    accountEntries = accounting_entries
    accountEntries.each {
      |x|  balance = balance + (x.ammount.to_f/100)
    }
    get_number_to_currency(balance)
  end

  def get_text_to_currency(number)
    number_to_currency(number[0...-3], :separator => ",", :delimiter => ".", format: "%n %u")
  end

  def get_number_to_currency(number)
    number_to_currency(number, :separator => ",", :delimiter => ".", format: "%n %u")
  end

  def get_payment_value
    payment_value(@person.role_wish).dup.sub! '.', ''
  end

end
