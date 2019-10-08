class VisitCounter
  def self.call(account)
    $redis.incr "account:#{account.id}:visits"
  end
end
