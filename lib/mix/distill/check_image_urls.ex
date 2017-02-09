#run task with 'mix distill.check_image_urls'
defmodule Mix.Tasks.Distill.CheckImageUrls do
    use Mix.Task

    @shortdoc "Checks image urls for 404s. Requires curl"
	def run([base_url]) do
        #start app so repo is available
        Mix.Task.run "app.start", []

        #parallel map based on:
        #http://elixir-recipes.github.io/concurrency/parallel-map/
    	Artour.Repo.all(Artour.Image)
    		|> Enum.flat_map(fn image -> image_sizes |> Enum.map(&(url_for_image(image, base_url, &1))) end)
    		|> Enum.map(&(Task.async(fn -> test_url(&1) end)))
    		|> Enum.map(&Task.await/1)
            |> Enum.each(&print_image_response/1)

    	IO.puts "All image urls checked"
	end

    def image_sizes() do
        [:thumbnail, :small, :medium, :large]
    end

    def print_image_response({status, message}) do
        if status != :ok do
            IO.puts message
        end
    end

	def url_for_image(image, base_url, size) do
		case size do
			:thumbnail -> URI.merge(base_url, image.filename_thumbnail) |> to_string
			:small -> URI.merge(base_url, image.filename_small) |> to_string
			:medium -> URI.merge(base_url, image.filename_medium) |> to_string
			:large -> URI.merge(base_url, image.filename_large) |> to_string
		end
	end
	
	@doc """
  	runs this curl command to get http status code
	curl -s -o /dev/null -w "%{http_code}" http://www.example.org/
	http://superuser.com/questions/272265/getting-curl-to-output-http-status-code
	have to use resolve because curl will not use hosts file
	http://stackoverflow.com/questions/3390549/set-curl-to-use-local-virtual-hosts
	return :ok if response is 200, else :error
  	"""
	def test_url(url) do
  		case System.cmd "curl", ["-s", "-o", "/dev/null", "-w", "%{http_code}", url] do
    		{"200", 0} -> {:ok, url <> " found"}
    		{_bad_status, _exit_code} -> {:error, url <> " not found"}
    	end
  	end
end