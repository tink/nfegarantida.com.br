module Jekyll
  class Page
    alias_method :original_to_liquid, :to_liquid

    def to_liquid
      original_to_liquid.deep_merge({
        "previous_ordered" => self.previous_ordered,
        "next_ordered"     => self.next_ordered })
    end

    def oi
      "oi"
    end

    def order
      self.data && self.data['order']
    end

    def previous_ordered
      pos = self.site.ordered_pages.index(self)
      if pos && pos > 0
        self.site.ordered_pages[pos - 1]
      else
        nil
      end
    end

    def next_ordered
      pos = self.site.ordered_pages.index(self)
      if pos && pos < self.site.ordered_pages.length - 1
        self.site.ordered_pages[pos + 1]
      else
        nil
      end
    end
  end

  class Site
    alias_method :original_site_payload, :site_payload

    def site_payload
      {"site" => original_site_payload['site'].merge({ 
       "ordered_pages" => ordered_pages })}
    end

    def ordered_pages
      self.pages.reject { |page| !page.order }.sort { |a,b| a.order <=> b.order }
    end

    def locate_page(name)
      self.pages.select { |page| page.name == name }
    end
  end
end
