module ConfigMe::Defaults
  class << self
    attr_accessor :namespace, :proc_auto_calling
  end

  self.namespace         = :production
  self.proc_auto_calling = true
end