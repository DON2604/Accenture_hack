import requests

def fetcher(location="New York"):
    """Fetch 10-day weather forecast using wttr.in API."""
    
    url = f"https://wttr.in/{location}?format=j1"
    
    try:
        response = requests.get(url, timeout=5)
        data = response.json()

        forecast_data = []
        for day in data["weather"]:
            forecast_data.append({
                "date": day["date"],
                "avg_temp": f"{day['avgtempC']}°C",
                "max_temp": f"{day['maxtempC']}°C",
                "min_temp": f"{day['mintempC']}°C",
                "conditions": day["hourly"][0]["weatherDesc"][0]["value"],
                "precipitation": f"{day['hourly'][0]['precipMM']}mm"
            })
        
        return {"location": location, "10_day_forecast": forecast_data}
    
    except requests.exceptions.RequestException as e:
        return {"error": str(e)}


