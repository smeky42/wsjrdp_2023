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

    unless authorize_view
      return
    end

    @authorize_view = authorize_view
    @accounting = accounting
    @accounting_entries = accounting_entries
    @accounting_payment_value = get_number_to_currency(total_payment_by(@person.role_wish))
    @accounting_payment_array = accounting_payment_array
    @accounting_balance = get_number_to_currency(- accounting_balance)
    @next_payment = get_number_to_currency(next_payment)
    @possible_sepa_states = Settings.person.sepa_status
    save_put
  end

  def authorize_view
    (current_user.role?('Group::Root::Admin') ||
    current_user.role?('Group::Root::Leader') ||
    current_user.role?('Group::UnitSupport::Leader') ||
    current_user.role?('Group::UnitSupport::Member') ||
    current_user.role?('Group::Ist::Leader') ||
    current_user == @person)
  end

  def accounting_value(value)
    number_to_currency(value.to_f / 100, separator: ',', delimiter: '.', format: '%n %u')
  end
  helper_method :accounting_value

  private

  # TODO: dynamic
  def next_payment
    to_pay = dept(0) + accounting_balance

    if to_pay < 0
      to_pay = 0
    end
    to_pay
  end

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

  # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
  def save_put
    if @accounting && request.put? && !params[:accounting_comment].nil? && !params[:accounting_ammount].nil?
      AccountingEntries.create(id: AccountingEntries.last.id + 1,
                               subject_id: @person.id,
                               author_id: current_user.id,
                               ammount: params[:accounting_ammount],
                               comment: params[:accounting_comment],
                               created_at: DateTime.now)

      @person.sepa_status = params[:sepa_status]
      @person.save

      flash[:notice] =
        "Buchung #{params[:accounting_comment]} in Höhe von #{get_number_to_currency(params[:accounting_ammount].to_i)} erfolgreich angelegt! Status auf #{params[:sepa_status]} gesetzt."
      redirect_back(fallback_location: '/')
    end
  end
  # rubocop:enable ,Metrics/MethodLength,Metrics/AbcSize

  def accounting_entries
    AccountingEntries.where(subject_id: @person.id)
  end

  def accounting_payment_array
    array = []
    start_date = Date.new(2021, 12, 5)
    payment_data = payment_data_till_date(@person.role_wish, Date.new(2023, 6, 6))
    payment_data.each_with_index do |_data, x|
      array.push({
                   month: start_date + x.months,
                   ammount: get_number_to_currency(payment_by_month(@person.role_wish, x)),
                   total: get_number_to_currency(dept(x))
                 })
    end

    array
  end

  def get_text_to_currency(number)
    number_to_currency(number.to_f / 100, separator: ',', delimiter: '.', format: '%n %u')
  end

  def get_number_to_currency(number)
    number_to_currency(number.to_f / 100, separator: ',', delimiter: '.', format: '%n %u')
  end

  def get_payment_value
    payment_value(@person.role_wish).dup.sub! '.', ''
  end

end
