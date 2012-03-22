class SimpleController < ApplicationController
    def index
        render :inline => "ok"
    end
end
