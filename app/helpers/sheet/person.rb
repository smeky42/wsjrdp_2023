# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

module Sheet
  class Person < Base

    self.parent_sheet = Sheet::Group

    tab 'global.tabs.info',
        :group_person_path,
        if: :show


    tab 'people.tabs.print',
        :print_group_person_path,
        if: :show

    tab 'people.tabs.upload',
        :upload_group_person_path,
        if: :show

    tab 'people.tabs.accounting',
        :accounting_group_person_path,
        if: (lambda do |view, _group, _person|
          view.current_user.role?('Group::Root::Admin') ||
          view.current_user.role?('Group::Root::Leader') ||
          view.current_user.role?('Group::UnitSupport::Leader') ||
          view.current_user.role?('Group::UnitSupport::Member') ||
          view.current_user.role?('Group::Ist::Leader') || 
          view.current_user == _person 
          # TODO: use view.can
        end)

    tab 'people.tabs.istjobs',
        :istjobs_group_person_path,
        if: (lambda do |view, _group, _person|
          view.current_user.role?('Group::Root::Admin') ||
          view.current_user.role?('Group::Root::Leader') ||
          view.current_user.role?('Group::UnitSupport::Leader') ||
          view.current_user.role?('Group::UnitSupport::Member') ||
          view.current_user.role?('Group::Ist::Leader') || 
          view.current_user == _person 
          # TODO: use view.can
        end)

    tab 'people.tabs.check',
        :check_group_person_path,
        if: (lambda do |view, _group, _person|
               view.current_user.role?('Group::Root::Admin') ||
               view.current_user.role?('Group::Root::Leader') ||
               view.current_user.role?('Group::UnitSupport::Leader') ||
               view.current_user.role?('Group::UnitSupport::Member') ||
               view.current_user.role?('Group::Ist::Leader') ||
               view.current_user.role?('Group::Unit::Leader')
               # TODO: use view.can
             end)


    if Settings.people.abos
      tab 'people.tabs.subscriptions',
          :group_person_subscriptions_path,
          # if: :show_details
          if: (lambda do |view, _group, _person|
            view.current_user.role?('Group::Root::Admin')
            # TODO: use view.can
          end)
    end

    tab 'people.tabs.invoices',
        :invoices_group_person_path,
        if: (lambda do |view, group, person|
          person.finance_groups.present? &&
            (view.can?(:index_invoices, group) || view.can?(:index_invoices, person))
        end)

    tab 'activerecord.models.message.other',
        :messages_group_person_path,
        # if: (lambda do |view, _group, person|
        #   view.can?(:show_details, person) && person.roles.any?
        # end)
        if: (lambda do |view, _group, _person|
          view.current_user.role?('Group::Root::Admin')
          # TODO: use view.can
        end)

    tab 'people.tabs.history',
        :history_group_person_path,
        # if: (lambda do |view, _group, person|
        #   view.can?(:history, person)
        # end)
        if: (lambda do |view, _group, _person|
          view.current_user.role?('Group::Root::Admin')
          # TODO: use view.can
        end)

    tab 'people.tabs.log',
        :log_group_person_path,
        if: (lambda do |view, _group, _person|
               view.current_user.role?('Group::Root::Admin') ||
               view.current_user.role?('Group::Root::Leader') ||
               view.current_user.role?('Group::UnitSupport::Leader') ||
               view.current_user.role?('Group::UnitSupport::Member') ||
               view.current_user.role?('Group::Ist::Leader')
               # TODO: use view.can
             end)

    tab 'people.tabs.colleagues',
        :colleagues_group_person_path,
        if: (lambda do |_view, _group, person|
          person.company_name?
        end)

    if Settings.assignments&.enabled
      tab 'activerecord.models.assignment.other',
          :group_person_assignments_path,
          if: :show_details
    end

    def link_url
      view.group_person_path(parent_sheet.entry.id, entry.id)
    end

  end
end
