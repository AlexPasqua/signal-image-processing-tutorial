x = 0:.001:1;
in = sin(2*pi*x*2); %clean signal (2Hz)
in = awgn(in, 20); %gaussian noise
in = in + 0.2*sin(2*pi*x*40); %adding noise at 40Hz
in = in + 0.3*sin(2*pi*x*60); %adding noise at 60Hz
in = in + 0.13*sin(2*pi*x*39); %adding noise at 39Hz


% Low-pass filtering
LENGTH = length(in);
[b,a] = butter(7, 30/(1000/2), 'low'); %transfer function coeffs.
alen = length(a); blen = length(b); maxlen = max(alen, blen);
out = zeros([1 LENGTH]); %output signal

for i = maxlen : LENGTH
    %auxiliar variables
    right_part = 0;
    left_part = 0;

    for j = 1:blen
        right_part = right_part + b(j) * in(i-j+1);
    end
    
    for j = 2:alen
        left_part = left_part + a(j) * out(i-j+1);
    end

    out(i) = (right_part - left_part) / a(1);
end



% Moving avarage filter
window = 31.0;
halfwin = floor(window/2);

out2 = zeros([1 LENGTH]);   out2(1) = in(1);    out2(LENGTH) = in(LENGTH);
sum = in(1) + in(2) + in(3);    out2(2) = sum / 3.0;
current_win_limit = 3.0; %dimension of the window at the beginning and at the end (when we have less than 'window' samples)

for i = 3 : LENGTH-1
    % beginning
    if i <= halfwin + 1
        for current_win_limit = current_win_limit + 1 : current_win_limit + 2
            sum = sum + in(current_win_limit);
        end
        out2(i) = sum / current_win_limit;

    % ending (check 'main part' first)
    elseif i >= LENGTH - halfwin + 1
        for current_win_limit = current_win_limit + 1 : current_win_limit + 2
            sum = sum - in(current_win_limit);
        end
        out2(i) = sum / (LENGTH - current_win_limit);

    % main part 
    else
        sum = sum - in(i - halfwin - 1) + in(i + halfwin);
        out2(i) = sum / window;
        % last step befor falling into the "ending" case
        if i == LENGTH - halfwin
            current_win_limit = i - halfwin - 1;
        end
    end    
end



% Mov. avarage filtering over the previously low-pass filtered signal
out3 = zeros([1 LENGTH]);   out3(1) = out(1);   out3(LENGTH) = out(LENGTH);
sum = out(1) + out(2) + out(3);     out3(2) = sum / 3.0;
current_win_limit = 3.0;

for i = 3 : LENGTH-1
    % beginning
    if i <= halfwin + 1
        for current_win_limit = current_win_limit + 1 : current_win_limit + 2
            sum = sum + out(current_win_limit);
        end
        out3(i) = sum / current_win_limit;

    % ending
    elseif i >= LENGTH - halfwin + 1
        for current_win_limit = current_win_limit + 1 : current_win_limit + 2
            sum = sum - out(current_win_limit);
        end
        out3(i) = sum / (LENGTH - current_win_limit);

    % main part 
    else
        sum = sum - out(i - halfwin - 1) + out(i + halfwin);
        out3(i) = sum / window;
        % last step befor falling into the "ending" case
        if i == LENGTH - halfwin
            current_win_limit = i - halfwin - 1;
        end
    end    
end



% plotting
figure, plot(abs(fft(in)), 'r'), title('Input signal spectrum')
figure, plot(abs(fft(out)), 'b'), title('Low-pass filtered signal spectrum')
figure, plot(abs(fft(out2)), 'g'), title('Moving avarage filtered signal spectrum')

figure, plot(x, in, 'r', x, out, 'b', x, out2, 'g', x, out3, 'c')
xlabel('time'), ylabel('magnitude'), title('Time-domain signal comparing')
legend('input', 'Low-pass filtered signal', 'Mov. avrg. filtered signal', 'Mov. avrg. over low-pass filtered signal')

figure, plot(x, out, 'r', x, out3, 'b')
xlabel('time'), ylabel('magnitude'), legend('Low-pass filtered signal', 'Mov.avrg. over low-pass filtered signal')
