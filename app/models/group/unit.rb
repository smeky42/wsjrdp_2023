# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.


# TODO: rename class to specific name and change all references
class Group::Unit < ::Group

  self.layer = true

  ### ROLES
  class Leader < ::Role
    self.permissions = [:group_full]
  end

  class Member < ::Role
    self.permissions = []
  end

  class UnassignedLeader < ::Role
    self.permissions = []
  end

  class UnassignedMember < ::Role
    self.permissions = []
  end

  roles Leader, Member, UnassignedLeader, UnassignedMember

end
