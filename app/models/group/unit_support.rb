# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.


# TODO: rename class to specific name and change all references
class Group::UnitSupport < ::Group

  self.layer = true

  children Group::Unit

  ### ROLES
  class Leader < ::Role
    self.permissions = [:layer_and_below_full]
  end

  class Member < ::Role
    self.permissions = [:layer_and_below_full]
  end

  roles Leader, Member

end
