location = 'CA1'

ca1list = [];

for d = 1:length(cellinfo)

    for e  = 1:length(cellinfo{d})

        for t = 1:length(cellinfo{d}{e})

            for c = 1:length(cellinfo{d}{e}{t})

                if ~isempty(cellinfo{d}{e}{t}{c}) && strcmp(cellinfo{d}{e}{t}{c}.location, location)

                    ca1list = [ca1list ; d e t c];

                end

            end

          end

    end
end