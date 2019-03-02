class ContributorBadge < BaseBadge
  def id
    'contributor'
  end

  def metadata
    {}
  end

  def eligible?
    user.is_contributor? || user.is_staff?
  end
end
