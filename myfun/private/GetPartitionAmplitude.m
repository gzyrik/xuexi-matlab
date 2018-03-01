function scaled_amplitude = GetPartitionAmplitude(data)
DC=sum(data);
energy = sum(abs(data));
energy = (energy - abs(DC)) / length(data);
scaled_amplitude = sqrt(energy);
