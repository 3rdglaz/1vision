import { Search } from "@mui/icons-material";
import { Grid, InputAdornment, Tab } from "@mui/material";
import { useRouter } from "next/router";
import { useState } from "react";
import { PostCard } from "../PostCard";
import { StyledTabs, StyledTextField } from "./styles";

type Props = {};

export const Timeline = (props: Props) => {
  const router = useRouter();
  const [value, setValue] = useState(0);

  const handleChangeTab = (event: any, newValue: number) => {
    setValue(newValue);
  };

  return (
    <Grid container padding={2} rowGap={3} sx={{ backgroundColor: "#FFF" }}>
      <Grid item xs={12}>
        <StyledTabs
          centered
          value={value}
          textColor="secondary"
          indicatorColor="secondary"
          onChange={handleChangeTab}
        >
          <Tab label="Most recent" />
          <Tab label="Popular" />
        </StyledTabs>
      </Grid>
      <Grid item xs={12}>
        <StyledTextField
          fullWidth
          placeholder="Search a recipe for you"
          InputProps={{
            color: "secondary",
            endAdornment: (
              <InputAdornment position="start">
                <Search color="secondary" />
              </InputAdornment>
            ),
          }}
        />
      </Grid>
      <Grid item xs={12}>
        {Array.from(Array(10)).map((_, i) => (
          <PostCard
            key={i.toString()}
            user="Sundays posted"
            image="https://picsum.photos/600/600"
            title="Perfect Chicken for a Night"
            rating={4}
            likes={20}
            time="30 minutes"
            tags={["#chicken", "#brazilian food", "#honey", "#mustard"]}
          />
        ))}
      </Grid>
    </Grid>
  );
};
