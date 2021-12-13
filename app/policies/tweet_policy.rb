class TweetPolicy < ApplicationPolicy
    def update?
        user.has_role? :moderator
    end
end